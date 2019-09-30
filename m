From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 1/2] drm/qxl: stop abusing TTM to call driver internal
	functions
Date: Mon, 30 Sep 2019 08:11:52 +0200
Message-ID: <20190930061152.abljqdshqjhzioao__34535.7500411168$1569823928$gmane$org@sirius.home.kraxel.org>
References: <20190927132458.4359-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190927132458.4359-1-christian.koenig@amd.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>
Cc: airlied@redhat.com, dri-devel@lists.freedesktop.org, spice-devel@lists.freedesktop.org, daniel@ffwll.ch, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 27, 2019 at 03:24:57PM +0200, Christian K=F6nig wrote:
> The ttm_mem_io_* functions are actually internal to TTM and shouldn't be
> used in a driver.
> =

> Instead call the qxl_ttm_io_mem_reserve() function directly.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
