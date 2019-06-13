From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 12/13] drm/virtio: drop DRM_AUTH usage from the driver
Date: Thu, 13 Jun 2019 09:00:16 +0200
Message-ID: <20190613070016.sllkspqodporxtvp__14700.0204467744$1560409231$gmane$org@sirius.home.kraxel.org>
References: <20190527081741.14235-1-emil.l.velikov@gmail.com>
	<20190527081741.14235-12-emil.l.velikov@gmail.com>
	<CACvgo51+WknrTjzEhc6EitJV5EA0f9SXznQMkw3Y_ixPHSOLPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CACvgo51+WknrTjzEhc6EitJV5EA0f9SXznQMkw3Y_ixPHSOLPQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 06, 2019 at 11:59:15AM +0100, Emil Velikov wrote:
> On Mon, 27 May 2019 at 09:19, Emil Velikov <emil.l.velikov@gmail.com> wrote:
> >
> > From: Emil Velikov <emil.velikov@collabora.com>
> >
> > The authentication can be circumvented, by design, by using the render
> > node.
> >
> > From the driver POV there is no distinction between primary and render
> > nodes, thus we can drop the token.
> >
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Cc: virtualization@lists.linux-foundation.org
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Signed-off-by: Emil Velikov <emil.velikov@collabora.com>

Acked-by: Gerd Hoffmann <kraxel@redhat.com>
