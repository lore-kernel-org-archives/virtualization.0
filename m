From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 0/4] Improve virtio ID allocation
Date: Tue, 30 Oct 2018 09:52:22 -0700
Message-ID: <20181030165222.GA10491__14294.7702472613$1540918277$gmane$org@bombadil.infradead.org>
References: <20180926160031.15721-1-willy@infradead.org>
	<20181029215339.aywdmehccrwwls2n@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181029215339.aywdmehccrwwls2n@sirius.home.kraxel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Oct 29, 2018 at 10:53:39PM +0100, Gerd Hoffmann wrote:
> On Wed, Sep 26, 2018 at 09:00:27AM -0700, Matthew Wilcox wrote:
> > I noticed you were using IDRs where you could be using the more efficient
> > IDAs, then while fixing that I noticed the lack of error handling,
> > and I decided to follow that up with an efficiency improvement.
> > 
> > There's probably a v2 of this to follow because I couldn't figure
> > out how to properly handle one of the error cases ... see the comment
> > embedded in one of the patches.
> 
> #1 + #2 pushed to drm-misc-next now.
> #3 should not be needed any more.
> waiting for v2 of #4 ...

Thanks!  I think we do still need a small part of #3.  Patches in
replies to this email.
