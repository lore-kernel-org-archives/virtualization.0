From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: bochs_drm: failed bochs_hw_init() results in panic
Date: Fri, 10 Jan 2020 06:35:53 +0100
Message-ID: <20200110053553.4gqlagjdpfi6pg3b@sirius.home.kraxel.org>
References: <20200110013328.GA12596@mail-itl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200110013328.GA12596@mail-itl>
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
To: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 10, 2020 at 02:33:28AM +0100, Marek Marczykowski-G=F3recki wrot=
e:
> Hi,
> =

> It looks like bochs_kms_fini() don't like being called if
> bochs_kms_init() wasn't. Regardless of the reason for the
> bochs_hw_init() failure (that's another story), it shouldn't cause a
> panic. Any idea how to fix it?

maybe this?

diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/boch=
s_kms.c
index 3f0006c2470d..322be68a238a 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -192,6 +192,9 @@ int bochs_kms_init(struct bochs_device *bochs)
 =

 void bochs_kms_fini(struct bochs_device *bochs)
 {
+	if (!dev->mode_config.num_connector)
+		return;
+
 	drm_atomic_helper_shutdown(bochs->dev);
 	drm_mode_config_cleanup(bochs->dev);
 }
