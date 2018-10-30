From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] gpu/drm/virtio/virtgpu_vq.c: Use kmem_cache_zalloc
Date: Tue, 30 Oct 2018 06:36:35 +0100
Message-ID: <20181030053635.xwys3njelwa4j4vc__34165.9052217894$1540877696$gmane$org@sirius.home.kraxel.org>
References: <5bc9ff7e.1c69fb81.105c2.1fef@mx.google.com>
	<CAFqt6zbdxjUF4tEh8WXRZT-eo58sfw0tKa3DyxTXCesjEJkqfA@mail.gmail.com>
	<87sh0xc7pv.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87sh0xc7pv.fsf@intel.com>
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
Cc: Sabyasachi Gupta <sabyasachi.linux@gmail.com>, airlied@linux.ie, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Souptick Joarder <jrdr.linux@gmail.com>, Brajeswar Ghosh <brajeswar.linux@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Oct 23, 2018 at 12:50:36PM +0300, Jani Nikula wrote:
> On Tue, 23 Oct 2018, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> > On Fri, Oct 19, 2018 at 9:30 PM Sabyasachi Gupta
> > <sabyasachi.linux@gmail.com> wrote:
> >>
> >> Replaced kmem_cache_alloc + memset with kmem_cache_zalloc
> >
> > Put a new line gap in between these two lines and send v2.
> 
> Nah, the maintainers can trivially add the newline while
> applying. Review is much more valuable than nitpicking on the commit
> message.

Queued (and added newline).

thanks,
  Gerd
