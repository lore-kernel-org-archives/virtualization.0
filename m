From: Daniel Verkamp <dverkamp@chromium.org>
Subject: Re: [PATCH 1/2] virtio-balloon: initialize all vq callbacks
Date: Tue, 17 Dec 2019 12:10:35 -0800
Message-ID: <CABVzXAkeYehSS_DWTBm0Ebx+ei+_TFmdBGEgxXHAsb4rVBrU-A@mail.gmail.com>
References: <20191217190610.248061-1-dverkamp@chromium.org>
 <20191217150500-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191217150500-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 17, 2019 at 12:05 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Dec 17, 2019 at 11:06:09AM -0800, Daniel Verkamp wrote:
> > Ensure that elements of the array that correspond to unavailable
> > features are set to NULL; previously, they would be left uninitialized.
> >
> > Since the corresponding names array elements were explicitly set to
> > NULL, the uninitialized callback pointers would not actually be
> > dereferenced; however, the uninitialized callbacks elements would still
> > be read in vp_find_vqs_msix() and used to calculate the number of MSI-X
> > vectors required.
> >
> > Fixes: 86a559787e6f ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
> > Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
>
> Actually, we already have the issue with the stats VQ, no?
>
> So I think this one is more appropriate:
> Fixes: 9564e138b1f6 ("virtio: Add memory statistics reporting to the balloon driver (V4)")

I think things were OK in 9564e138b1f6 because nvqs was calculated
based on the available features, so the later elements of the array
would not have been inspected by find_vqs.  86a559787e6f introduced
the uninitialized array elements as well as the removal of dynamic
nvqs based on features.
