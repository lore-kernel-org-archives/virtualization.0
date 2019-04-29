From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Spice-devel] [PATCH] Revert "drm/qxl: drop prime import/export
	callbacks"
Date: Mon, 29 Apr 2019 16:44:40 +0200
Message-ID: <CAKMK7uE_+-pFuVrqznj9ZbRxwyNM9mRhoY-y4xCBjjY9Z-sNDg__32118.1118766376$1556549568$gmane$org@mail.gmail.com>
References: <20190426053324.26443-1-kraxel@redhat.com>
	<CAKMK7uG+vMU0hqqiKAswu=LqpkcXtLPqbYLRWgoAPpsQQV4qzA@mail.gmail.com>
	<20190429075413.smcocftjd2viznhv@sirius.home.kraxel.org>
	<CAKMK7uFB8deXDMP9cT634p_dK5LsM37R1v_vGhAEY1ZLZ+WBVA@mail.gmail.com>
	<20190429143757.yljjfsgobhi23xnb@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190429143757.yljjfsgobhi23xnb@sirius.home.kraxel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, David Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 29, 2019 at 4:38 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > More useful would be some way to signal this self-reimport capability
> > > to userspace somehow.  See DRM_PRIME_CAP_LOCAL patch.
> >
> > Userspace is supposed to test whether import/export works for a
> > specific combo, not blindly assume it does and then keel over. I think
> > we need to fix that, not add more flags - there's lots of reasons why
> > a given pair of devices can't share buffers (e.g. all the contiguous
> > allocations stuff on socs).
>
> Ok.  Lets scratch the DRM_PRIME_CAP_LOCAL idea then and blame userspace
> instead.
>
> > > Right now I have the choice to set DRM_PRIME_CAP_{IMPORT,EXPORT}, in
> > > which case some userspace assumes it can do cross-driver export/import
> > > and trips over that not working.  Or I do not set
> > > DRM_PRIME_CAP_{IMPORT,EXPORT}, which breaks DRI3 ...
> >
> > Yeah that's not an option.
>
> Good.  Can I get an ack for this patch then, as it unbreaks DRI3 with qxl?

Oh sure, acked-by: me. Sorry forgot to supply that ...
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
