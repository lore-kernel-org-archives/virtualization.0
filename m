From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [Spice-devel] [PATCH] Revert "drm/qxl: drop prime import/export
	callbacks"
Date: Mon, 29 Apr 2019 16:37:57 +0200
Message-ID: <20190429143757.yljjfsgobhi23xnb__11627.6008704276$1556548893$gmane$org@sirius.home.kraxel.org>
References: <20190426053324.26443-1-kraxel@redhat.com>
	<CAKMK7uG+vMU0hqqiKAswu=LqpkcXtLPqbYLRWgoAPpsQQV4qzA@mail.gmail.com>
	<20190429075413.smcocftjd2viznhv@sirius.home.kraxel.org>
	<CAKMK7uFB8deXDMP9cT634p_dK5LsM37R1v_vGhAEY1ZLZ+WBVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAKMK7uFB8deXDMP9cT634p_dK5LsM37R1v_vGhAEY1ZLZ+WBVA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Vetter <daniel@ffwll.ch>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, David Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> > More useful would be some way to signal this self-reimport capability
> > to userspace somehow.  See DRM_PRIME_CAP_LOCAL patch.
> 
> Userspace is supposed to test whether import/export works for a
> specific combo, not blindly assume it does and then keel over. I think
> we need to fix that, not add more flags - there's lots of reasons why
> a given pair of devices can't share buffers (e.g. all the contiguous
> allocations stuff on socs).

Ok.  Lets scratch the DRM_PRIME_CAP_LOCAL idea then and blame userspace
instead.

> > Right now I have the choice to set DRM_PRIME_CAP_{IMPORT,EXPORT}, in
> > which case some userspace assumes it can do cross-driver export/import
> > and trips over that not working.  Or I do not set
> > DRM_PRIME_CAP_{IMPORT,EXPORT}, which breaks DRI3 ...
> 
> Yeah that's not an option.

Good.  Can I get an ack for this patch then, as it unbreaks DRI3 with qxl?

thanks,
  Gerd
