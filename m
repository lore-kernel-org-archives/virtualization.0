From: Bart Van Assche <Bart.VanAssche@wdc.com>
Subject: Re: 4.14: WARNING: CPU: 4 PID: 2895 at block/blk-mq.c:1144 with
	virtio-blk
Date: Mon, 20 Nov 2017 19:20:46 +0000
Message-ID: <1511205644.2396.32.camel__13481.8997503773$1511205660$gmane$org@wdc.com>
References: <9c5eec5d-f542-4d76-6933-6fe31203ce09@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <9c5eec5d-f542-4d76-6933-6fe31203ce09@de.ibm.com>
Content-Language: en-US
Content-ID: <2720606603FE544E841D72DEC14EB043@namprd04.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "axboe@kernel.dk" <axboe@kernel.dk>, "jasowang@redhat.com" <jasowang@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2017-11-17 at 15:42 +0100, Christian Borntraeger wrote:
> This is 
> 
> b7a71e66d (Jens Axboe                2017-08-01 09:28:24 -0600 1141)     * are mapped to it.
> b7a71e66d (Jens Axboe                2017-08-01 09:28:24 -0600 1142)     */
> 6a83e74d2 (Bart Van Assche           2016-11-02 10:09:51 -0600 1143)    WARN_ON(!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) &&
> 6a83e74d2 (Bart Van Assche           2016-11-02 10:09:51 -0600 1144)            cpu_online(hctx->next_cpu));
> 6a83e74d2 (Bart Van Assche           2016-11-02 10:09:51 -0600 1145) 
> b7a71e66d (Jens Axboe                2017-08-01 09:28:24 -0600 1146)    /*

Did you really try to figure out when the code that reported the warning
was introduced? I think that warning was introduced through the following
commit:

commit fd1270d5df6a005e1248e87042159a799cc4b2c9
Date:   Wed Apr 16 09:23:48 2014 -0600

    blk-mq: don't use preempt_count() to check for right CPU
     
    UP or CONFIG_PREEMPT_NONE will return 0, and what we really
    want to check is whether or not we are on the right CPU.
    So don't make PREEMPT part of this, just test the CPU in
    the mask directly.

Anyway, I think that warning is appropriate and useful. So the next step
is to figure out what work item was involved and why that work item got
executed on the wrong CPU.

Bart.
