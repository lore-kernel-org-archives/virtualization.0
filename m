From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH] gpu/drm/virtio/virtgpu_vq.c: Use kmem_cache_zalloc
Date: Tue, 23 Oct 2018 12:50:36 +0300
Message-ID: <87sh0xc7pv.fsf__6463.30092936314$1540288142$gmane$org@intel.com>
References: <5bc9ff7e.1c69fb81.105c2.1fef@mx.google.com>
	<CAFqt6zbdxjUF4tEh8WXRZT-eo58sfw0tKa3DyxTXCesjEJkqfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAFqt6zbdxjUF4tEh8WXRZT-eo58sfw0tKa3DyxTXCesjEJkqfA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Souptick Joarder <jrdr.linux@gmail.com>, Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc: airlied@linux.ie, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Brajeswar Ghosh <brajeswar.linux@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 23 Oct 2018, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> On Fri, Oct 19, 2018 at 9:30 PM Sabyasachi Gupta
> <sabyasachi.linux@gmail.com> wrote:
>>
>> Replaced kmem_cache_alloc + memset with kmem_cache_zalloc
>
> Put a new line gap in between these two lines and send v2.

Nah, the maintainers can trivially add the newline while
applying. Review is much more valuable than nitpicking on the commit
message.

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

>
>> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
>> ---
>>  drivers/gpu/drm/virtio/virtgpu_vq.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
>> index 020070d..e001b79 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
>> @@ -98,10 +98,9 @@ virtio_gpu_get_vbuf(struct virtio_gpu_device *vgdev,
>>  {
>>         struct virtio_gpu_vbuffer *vbuf;
>>
>> -       vbuf = kmem_cache_alloc(vgdev->vbufs, GFP_KERNEL);
>> +       vbuf = kmem_cache_zalloc(vgdev->vbufs, GFP_KERNEL);
>>         if (!vbuf)
>>                 return ERR_PTR(-ENOMEM);
>> -       memset(vbuf, 0, VBUFFER_SIZE);
>>
>>         BUG_ON(size > MAX_INLINE_CMD_SIZE);
>>         vbuf->buf = (void *)vbuf + sizeof(*vbuf);
>> --
>> 2.7.4
>>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Jani Nikula, Intel Open Source Graphics Center
