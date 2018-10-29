From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3] drm/bochs: add edid support.
Date: Mon, 29 Oct 2018 21:05:20 +0100
Message-ID: <20181029200520.jfnmvbkng2er5qbc__11055.7145708755$1540843412$gmane$org@sirius.home.kraxel.org>
References: <20181029134507.7775-1-kraxel@redhat.com>
	<87in1kejgj.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87in1kejgj.fsf@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: David Airlie <airlied@linux.ie>, David Airlie <airlied@redhat.com>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Oct 29, 2018 at 07:44:28PM +0200, Jani Nikula wrote:
> On Mon, 29 Oct 2018, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > Recent qemu (latest master branch, upcoming 3.1 release) got support
> > for EDID data.  This patch adds guest driver support.
> >
> > EDID support in qemu is not (yet) enabled by default, so please use
> > 'qemu -device VGA,edid=on' for testing.
> 
> Any chance of making this use drm_get_edid() (requires an i2c_adapter)
> or at least drm_do_get_edid()?

I'll have a look at using drm_do_get_edid().  drm_get_edid() will not
fly as there is no i2c adapter in the first place.

cheers,
  Gerd
