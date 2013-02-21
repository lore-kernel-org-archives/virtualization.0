From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 00/16] virtio ring rework.
Date: Thu, 21 Feb 2013 17:00:04 +1030
Message-ID: <877gm2gowj.fsf@rustcorp.com.au>
References: <1361260594-601-1-git-send-email-rusty@rustcorp.com.au>
	<512342B8.7060203@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <512342B8.7060203@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Paolo Bonzini <pbonzini@redhat.com> writes:
> Il 19/02/2013 08:56, Rusty Russell ha scritto:
>> OK, this is (ab)uses some of Paolo's patches.  The first 7 are
>> candidates for this merge window (maybe), the rest I'm not so sure
>> about.
>
> Cool, thanks.
>
>> Thanks,
>> Rusty.
>> 
>> Paolo Bonzini (3):
>>   scatterlist: introduce sg_unmark_end
>>   virtio-blk: reorganize virtblk_add_req
>>   virtio-blk: use virtqueue_add_sgs on req path
>> 
>> Rusty Russell (13):
>>   virtio_ring: virtqueue_add_sgs, to add multiple sgs.
>>   virtio-blk: use virtqueue_start_buf on bio path
>
> Something wrong with author and commit message in this patch.

Re: author.  I mangled your patch pretty badly in that case, so I wasn't
sure you wanted the blame.

I have restore your authorship.

Thanks,
Rusty.
