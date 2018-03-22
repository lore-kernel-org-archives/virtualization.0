From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 20/23] drm/virtio: Stop updating plane->fb
Date: Thu, 22 Mar 2018 17:11:47 +0100
Message-ID: <20180322161147.pfnenr2uscojnpa7__12042.973508551$1521734992$gmane$org@sirius.home.kraxel.org>
References: <20180322152313.6561-1-ville.syrjala@linux.intel.com>
	<20180322152313.6561-21-ville.syrjala@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180322152313.6561-21-ville.syrjala@linux.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ville Syrjala <ville.syrjala@linux.intel.com>
Cc: David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

> We want to get rid of plane->fb on atomic drivers. Stop setting it.

> -	primary->crtc = crtc;
> -	cursor->crtc = crtc;

commit msg vs. patch content mismatch here ...

cheers,
  Gerd
