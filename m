From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: Potential Memory Leak Bugs in
 drivers/gpu/drm/virtio/virtgpu_vq.c (Linux 5.6).
Date: Thu, 28 May 2020 10:25:23 +0200
Message-ID: <20200528082523.mvurcvr6ohbziad5@sirius.home.kraxel.org>
References: <CAFSR4ctYjWc8LSqb96Suwprv9=Gd0+vVPZ5pLn+5u1CV7wTq9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAFSR4ctYjWc8LSqb96Suwprv9=Gd0+vVPZ5pLn+5u1CV7wTq9Q@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Dongyang Zhan <zdyzztq@gmail.com>
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 28, 2020 at 03:57:05PM +0800, Dongyang Zhan wrote:
> Hi,
> My name is Dongyang Zhan, I am a security researcher.
> Currently, I found two possible memory bugs in
> drivers/gpu/drm/virtio/virtgpu_vq.c (Linux 5.6).
> I hope you can help me to confirm them. Thank you.

Sorry.  Not confirmed.  You should do a better job verifying your
claims before bugging people.

> The first one is resp_buf will not be release in
> virtio_gpu_cmd_get_display_info() with the condition
> (resp_size <= MAX_INLINE_RESP_SIZE) in virtio_gpu_alloc_cmd_resp().

In that code path resp_size equals sizeof(struct
virtio_gpu_resp_display_info) which is larger than MAX_INLINE_RESP_SIZE
so the condition is never true and no leak happens.

take care,
  Gerd
