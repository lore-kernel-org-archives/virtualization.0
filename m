From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 4/4] drm/virtio: Add memory barriers for capset cache.
Date: Thu, 13 Jun 2019 08:59:25 +0200
Message-ID: <20190613065925.c6c546uyp3n3nqk5__31110.2322697238$1560409178$gmane$org@sirius.home.kraxel.org>
References: <20190605234423.11348-1-davidriley@chromium.org>
	<20190610211810.253227-5-davidriley@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190610211810.253227-5-davidriley@chromium.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: davidriley@chromium.org
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 10, 2019 at 02:18:10PM -0700, davidriley@chromium.org wrote:
> From: David Riley <davidriley@chromium.org>
> 
> After data is copied to the cache entry, atomic_set is used indicate
> that the data is the entry is valid without appropriate memory barriers.
> Similarly the read side was missing the corresponding memory barriers.

All pushed to drm-misc-next

thanks,
  Gerd
