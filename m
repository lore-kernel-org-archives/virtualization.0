From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 1/1] drm/bochs: Fix connector leak during driver unload
Date: Tue, 21 May 2019 10:10:29 +0200
Message-ID: <20190521081029.dexgf7e7d3b7wxdw__11675.164189522$1558426262$gmane$org@sirius.home.kraxel.org>
References: <93b363ad62f4938d9ddf3e05b2a61e3f66b2dcd3.1558416473.git.sbobroff@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <93b363ad62f4938d9ddf3e05b2a61e3f66b2dcd3.1558416473.git.sbobroff@linux.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sam Bobroff <sbobroff@linux.ibm.com>
Cc: airlied@linux.ie, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, daniel@ffwll.ch, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

The bug is in the driver, so ...

> Bisecting the issue for commits to drivers/gpu/drm/bochs/ points to:
> 6579c39594ae ("drm/bochs: atomic: switch planes to atomic, wire up helpers.")
> ... but the issue also seems to be due to a change in the generic drm code

... this one is the culprit and should be listed.

> (reverting it separately fixes the issue):
> 846c7dfc1193 ("drm/atomic: Try to preserve the crtc enabled state in drm_atomic_remove_fb, v2.")
> ... so I've included both in the commit.  Is that the right thing to do?

That only triggers the driver bug.

I'll fix it up on commit,
  Gerd
