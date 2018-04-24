From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] gpu: drm: qxl: Adding new typedef vm_fault_t
Date: Tue, 24 Apr 2018 14:35:13 +0200
Message-ID: <20180424123513.53opt3ufe47i5db7@sirius.home.kraxel.org>
References: <20180417133844.GA30256@jordon-HP-15-Notebook-PC>
	<20180423104924.ozalv7x5ppjifnxc@sirius.home.kraxel.org>
	<20180424121151.GX31310@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180424121151.GX31310@phenom.ffwll.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Souptick Joarder <jrdr.linux@gmail.com>, airlied@linux.ie, linux-kernel@vger.kernel.org, willy@infradead.org, virtualization@lists.linux-foundation.org, dri-devel@lists.freedesktop.org, airlied@redhat.com, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Gustavo Padovan <gustavo@padovan.org>, Sean Paul <seanpaul@chromium.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 24, 2018 at 02:11:51PM +0200, Daniel Vetter wrote:
> On Mon, Apr 23, 2018 at 12:49:24PM +0200, Gerd Hoffmann wrote:
> > On Tue, Apr 17, 2018 at 07:08:44PM +0530, Souptick Joarder wrote:
> > > Use new return type vm_fault_t for fault handler. For
> > > now, this is just documenting that the function returns
> > > a VM_FAULT value rather than an errno. Once all instances
> > > are converted, vm_fault_t will become a distinct type.
> > > 
> > > Reference id -> 1c8f422059ae ("mm: change return type to
> > > vm_fault_t")
> > 
> > Hmm, that commit isn't yet in drm-misc-next.
> > Will drm-misc-next merge with 4.17-rcX soon?
> 
> For backmerge requests you need to cc/ping the drm-misc maintainers.
> Adding them. I think the hold-up also was that Dave was on vacations
> still.

Ah, ok.

So my expectation that a backmerge happens anyway after -rc1/2 is in
line with reality, it is just to be delayed this time.  I'll stay
tuned ;)

cheers,
  Gerd
