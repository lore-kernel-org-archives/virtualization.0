From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: INFO: task journal:337 blocked for more than 120 seconds
Date: Fri, 02 Oct 2009 12:13:26 -0700
Message-ID: <4AC650D6.5040800__15412.9379116513$1254510934$gmane$org@goop.org>
References: <1254345112.8837.9.camel@localhost.localdomain>	
	<4AC646D7.5030709@goop.org>
	<1254510407.7999.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1254510407.7999.3.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Shirley Ma <mashirle@us.ibm.com>
Cc: Andrew Jones <drjones@redhat.com>, kvm@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Kevin Bowling <kevinb@analograils.com>
List-Id: virtualization@lists.linuxfoundation.org

On 10/02/09 12:06, Shirley Ma wrote:
> On Fri, 2009-10-02 at 11:30 -0700, Jeremy Fitzhardinge wrote:
>   
>> I'm assuming from the lists you've posted to that this is under KVM? 
>> What disk drivers are you using (virtio or emulated)?
>>
>> Can you get a full stack backtrace of kjournald?
>>     
> Yes, it's under KVM, disk driver is virtio. Since the io has issue, the
> stack can't be saved on the disk. I have the image file attached here.
>   

Ah, thank you.  The backtrace does indeed look very similar.

(BTW, you could get a serial console with "qemu-kvm -nographic -append
console=ttyS0 ...")

    J
