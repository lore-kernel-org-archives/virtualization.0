From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/virtio: Drop deprecated load/unload initialization
Date: Tue, 8 Jan 2019 11:43:01 +0100
Message-ID: <20190108104301.wrsrgpen5gcjbsqh__37742.3932929107$1546944060$gmane$org@sirius.home.kraxel.org>
References: <20190103161600.19556-1-ezequiel@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190103161600.19556-1-ezequiel@collabora.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ezequiel Garcia <ezequiel@collabora.com>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 03, 2019 at 01:16:00PM -0300, Ezequiel Garcia wrote:
> Move the code around so the driver is probed the bus
> .probe and removed from the bus .remove callbacks.
> This commit is just a cleanup and shouldn't affect
> functionality.

Doesn't apply cleanly to drm-misc-next, and git can't find the parent
sha (for 3way merge) either.

Can you rebase and resend?

thanks,
  Gerd
