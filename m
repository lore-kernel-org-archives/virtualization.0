From: Asias He <asias.hejun@gmail.com>
Subject: Re: [PATCH 1/1] vhost-blk: Add vhost-blk support v4
Date: Thu, 8 Nov 2012 15:16:12 +0800
Message-ID: <CAFO3S42JoTLYfxB_DUewawMAo7-vzKpK=O2V6URw038pmZsfbg@mail.gmail.com>
References: <1350295023-9179-1-git-send-email-asias@redhat.com>
	<87wqxx2cxt.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87wqxx2cxt.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hello Rusty,

On Thu, Nov 8, 2012 at 7:47 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> Asias He <asias@redhat.com> writes:
>> vhost-blk is an in-kernel virito-blk device accelerator.
>>
>> Due to lack of proper in-kernel AIO interface, this version converts
>> guest's I/O request to bio and use submit_bio() to submit I/O directly.
>> So this version any supports raw block device as guest's disk image,
>> e.g. /dev/sda, /dev/ram0. We can add file based image support to
>> vhost-blk once we have in-kernel AIO interface. There are some work in
>> progress for in-kernel AIO interface from Dave Kleikamp and Zach Brown:
>>
>>    http://marc.info/?l=linux-fsdevel&m=133312234313122
>
> OK, this generally looks quite neat.  There is one significant bug,
> however:
>
>> +/* The block header is in the first and separate buffer. */
>> +#define BLK_HDR      0
>
> You need to do a proper pull off the iovec; you can't simply assume
> this.  I'm working on fixing qemu, too.

Yes.  I have changed the code to handle the buffer without assumption
about the layout already.
Just haven't sent out the new version. I will send it out after the kvm forum.

Cheers.

> linux/drivers/vhost/net.c simply skips the header, you want something
> which actually copies it from userspace:
>
> /* Returns 0, -EFAULT or -EINVAL (too short) */
> int copy_from_iovec_user(void *dst, size_t len, struct iovec *iov, int iov_nr);
> int copy_to_iovec_user(struct iovec *iov, int iov_nr, const void *src, size_t len);
>
> These consume the iov in place.  You could pass struct iovec **iov and
> int * if you wanted to be really efficient (otherwise you have
> zero-length iov entries at the front after you've pulled things off).
>
> This goes away:
>> +     if (hdr->type == VIRTIO_BLK_T_IN || hdr->type == VIRTIO_BLK_T_GET_ID)
>> +             iov_nr = in - 1;
>> +     else
>> +             iov_nr = out - 1;
>
> This becomes a simple assignment:
>
>> +     /* The block data buffer follows block header buffer */
>> +     req->iov        = &vq->iov[BLK_HDR + 1];
>
> This one actually requires iteration, since you should handle the case
> where the last iov is zero length:
>
>> +     /* The block status buffer follows block data buffer */
>> +     req->status     = vq->iov[iov_nr + 1].iov_base;
>
> This becomes copy_to_iovec_user:
>
>> +     case VIRTIO_BLK_T_GET_ID: {
>> +             char id[VIRTIO_BLK_ID_BYTES];
>> +             int len;
>> +
>> +             ret = snprintf(id, VIRTIO_BLK_ID_BYTES,
>> +                            "vhost-blk%d", blk->index);
>> +             if (ret < 0)
>> +                     break;
>> +             len = ret;
>> +             ret = __copy_to_user(req->iov[0].iov_base, id, len);
>
> This becomes copy_from_iovec_user:
>
>> +             if (unlikely(copy_from_user(&hdr, vq->iov[BLK_HDR].iov_base,
>> +                                         sizeof(hdr)))) {
>> +                     vq_err(vq, "Failed to get block header!\n");
>> +                     vhost_discard_vq_desc(vq, 1);
>> +                     break;
>> +             }
>
> The rest looks OK, at a glance.
>
> Thanks,
> Rusty.
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Asias He
