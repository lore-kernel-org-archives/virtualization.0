From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/qxl: remove unnecessary BUG_ON check for handle
Date: Fri, 6 Dec 2019 11:13:06 +0100
Message-ID: <20191206101306.rp2uxsmzgsshxey6__749.438539945402$1575627210$gmane$org@sirius.home.kraxel.org>
References: <20191205234231.10849-1-pakki001@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191205234231.10849-1-pakki001@umn.edu>
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
To: Aditya Pakki <pakki001@umn.edu>
Cc: David Airlie <airlied@linux.ie>, kjlu@umn.edu, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>, spice-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 05, 2019 at 05:42:31PM -0600, Aditya Pakki wrote:
> In qxl_gem_object_create_with_handle(), handle's memory is not
> allocated on the heap. Checking for failure of handle via BUG_ON
> is unnecessary. This patch eliminates the check.

The check makes sure the caller doesn't pass in handle == NULL
and it is needed.

cheers,
  Gerd
