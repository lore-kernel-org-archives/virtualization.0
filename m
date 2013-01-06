From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v2 1/5] virtio: add functions for piecewise addition of
	buffers
Date: Mon, 07 Jan 2013 10:02:57 +1030
Message-ID: <87sj6d51li.fsf__37272.7409158417$1357515791$gmane$org@rustcorp.com.au>
References: <1355833972-20319-1-git-send-email-pbonzini@redhat.com>
	<1355833972-20319-2-git-send-email-pbonzini@redhat.com>
	<87r4m45g88.fsf@rustcorp.com.au> <50E5481E.20801@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <50E5481E.20801@cn.fujitsu.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: kvm@vger.kernel.org, linux-scsi@vger.kernel.org, mst@redhat.com, hutao@cn.fujitsu.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Wanlong Gao <gaowanlong@cn.fujitsu.com> writes:
> On 01/02/2013 01:03 PM, Rusty Russell wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>> The virtqueue_add_buf function has two limitations:
>>>
>>> 1) it requires the caller to provide all the buffers in a single call;
>>>
>>> 2) it does not support chained scatterlists: the buffers must be
>>> provided as an array of struct scatterlist;
>> 
>> Chained scatterlists are a horrible interface, but that doesn't mean we
>> shouldn't support them if there's a need.
>> 
>> I think I once even had a patch which passed two chained sgs, rather
>> than a combo sg and two length numbers.  It's very old, but I've pasted
>> it below.
>> 
>> Duplicating the implementation by having another interface is pretty
>> nasty; I think I'd prefer the chained scatterlists, if that's optimal
>> for you.
>
> I rebased against virtio-next and use it in virtio-scsi, and tested it with 4 targets
> virtio-scsi devices and host cpu idle=poll. Saw a little performance regression here.

Sure, but now you should be able to eliminate virtscsi_map_sgl(), right?
You should be able to use scsi_out(sc) and scsi_in(sc) directly, which
is what Paulo wanted to do...

Right Paulo?

Thanks,
Rusty.
