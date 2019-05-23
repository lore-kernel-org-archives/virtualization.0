From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 2/4] drm/virtio: remove irrelevant DRM_UNLOCKED flag
Date: Thu, 23 May 2019 12:19:41 +0200
Message-ID: <20190523101941.dadeepnc3ynms5of@sirius.home.kraxel.org>
References: <20190522154702.16269-1-emil.l.velikov@gmail.com>
	<20190522154702.16269-2-emil.l.velikov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190522154702.16269-2-emil.l.velikov@gmail.com>
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
Cc: David Airlie <airlied@linux.ie>, kernel@collabora.com, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 22, 2019 at 04:47:00PM +0100, Emil Velikov wrote:
> From: Emil Velikov <emil.velikov@collabora.com>
> 
> DRM_UNLOCKED doesn't do anything for non-legacy drivers. Remove it.

Patch applied to drm-misc-next.

thanks,
  Gerd
