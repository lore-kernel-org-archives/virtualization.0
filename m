From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 2/6] drm: Add drm_simple_encoder_{init,create}()
Date: Fri, 7 Feb 2020 13:31:43 +0100
Message-ID: <20200207123143.y3m3moillue6udo6@sirius.home.kraxel.org>
References: <20200207084135.4524-1-tzimmermann@suse.de>
 <20200207084135.4524-3-tzimmermann@suse.de>
 <20200207103333.rxebukm4hukavlq5@sirius.home.kraxel.org>
 <cd78b79f-ff4e-9c8e-4d87-ce717a717559@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cd78b79f-ff4e-9c8e-4d87-ce717a717559@suse.de>
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
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: airlied@linux.ie, maarten.lankhorst@linux.intel.com, mripard@kernel.org, virtualization@lists.linux-foundation.org, noralf@tronnes.org, dri-devel@lists.freedesktop.org, daniel@ffwll.ch, alexander.deucher@amd.com, spice-devel@lists.freedesktop.org, sam@ravnborg.org, emil.velikov@collabora.com
List-Id: virtualization@lists.linuxfoundation.org

> > How about using
> > 
> > #define drm_simple_encoder_init(dev, type, name, ...) \
> >         drm_encoder_init(dev, drm_simple_encoder_funcs_cleanup, type, name, __VA_ARGS__)
> > 
> > instead ?

> I guess you want to save a few lines in the implementation of
> drm_simple_encoder_init() (?) If so, I'd rather try to share more
> internal code among the various init and create functions.

Yes.  You have the namestr stuff duplicated in all functions, and with
a #define that goes away.

But maybe that can be simply be dropped?  The drivers with a simple
encoder seem to not care much about the name and just pass NULL ...

cheers,
  Gerd
