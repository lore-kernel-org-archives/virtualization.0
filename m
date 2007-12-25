From: Dor Laor <dor.laor@gmail.com>
Subject: Re: virtio_net and SMP guests
Date: Tue, 25 Dec 2007 14:22:37 +0200
Message-ID: <4770F60D.4010904__47941.9497926303$1198585598$gmane$org@qumranet.com>
References: <200712141312.05562.borntraeger@de.ibm.com>
	<200712181751.24692.rusty@rustcorp.com.au>
	<476EECF7.9000204@qumranet.com>
	<200712241154.20885.rusty@rustcorp.com.au>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200712241154.20885.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Monday 24 December 2007 10:19:19 Dor Laor wrote:
>   
>> Rusty Russell wrote:
>> Looks good to me. The only thing is the naming.. Maybe one can find
>> better name than [dis|en]able_cb since
>> it is more like disable interrupts than disable_cb and enable_cb is more
>> like run_callbacks (and enable interrupts).
>>     
>
> Yes, the nomenclature is a little wishy-washy.  Perhaps we should call 
> them "interrupts" even though (all together) the s390 doesn't have 
> interrupts.
>
>   
>> Actually while looking at it some more, there's might be a performance
>> optimization using your new patch:
>> Up to now, if the tx/rx paths were running out of descriptors they
>> called enable_cb.
>> enable_cb told the host it should trigger an irq the next time it has
>> data for the guest.
>>  From now on, enable_cb will run the callbacks inside shortening latency.
>>
>> btw, I tried to apply this patch on my source tree without luck,  after
>> doing a manual merge, the
>> guest opssed on the BUG_ON. I think it's because my sources are not
>> aligned with yours.
>> Can you please post a mercurial/git repo? Please specify the relatively
>> repository in case you choose mercurial.
>>     
>
> Hmm, I currently publish a patch queue and a subset of that for Linus to pull 
> from.  I could create a git tree from it but it'd be useless to you, since 
> it'd be re-created every time I modify the patch queue...
>
> Rusty.
>   
It's ok with me, anyway I always pull from Avi & you and try push new 
patches back.
btw: I checked your Linux tree and found it a bit old, there was no tx 
coalescing timer, it's probably good
for 2.6.24. Do you plan to post patchset for 25 windows?
Thanks,
Dor
