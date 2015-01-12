From: Sebastian Parschauer <sebastian.riemer@profitbricks.com>
Subject: Re: blk-mq v3.18: Oops during virtio_blk hot-unplug
Date: Mon, 12 Jan 2015 10:30:21 +0100
Message-ID: <54B3942D.2080006__15900.7436749109$1421083904$gmane$org@profitbricks.com>
References: <54AFE664.6010002@profitbricks.com>
	<20150110012036.GC8570@fam-t430.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150110012036.GC8570@fam-t430.nay.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Fam Zheng <famz@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eduardo Otubo <eduardo.otubo@profitbricks.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 10.01.2015 02:20, Fam Zheng wrote:
> On Fri, 01/09 15:32, Sebastian Parschauer wrote:
>> Hi Jens,
>>
>> my colleague Eduardo is sporadically seeing an Oops in blk-mq while
>> running continuous virtio_blk hot-plug/hot-unplug tests with I/O to the
>> device within an x86_64 QEMU/KVM 2.0 Debian Wheezy VM.
>>
>> Please find the call trace attached and the full log here:
>> http://paste.ubuntu.com/9691873/
>>
>> The kernel image has been taken from here and is the mainline kernel
>> from tag v3.18:
>> http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.18-vivid/
>>
>> Is there still an issue with block queue freezing?
> 
> This one?
> 
> commit 45a9c9d909b24c6ad0e28a7946e7486e73010319
> Author: Bart Van Assche <bvanassche@acm.org>
> Date:   Tue Dec 9 16:57:48 2014 +0100
> 
>     blk-mq: Fix a use-after-free
> 
> Fam

Yes, pretty much looks like it, thanks!

Cheers,
Sebastian
