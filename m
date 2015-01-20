From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 00/16] virtio-pci: towards virtio 1.0 guest support
Date: Tue, 20 Jan 2015 18:38:00 +0200
Message-ID: <20150120163800.GB1785@redhat.com>
References: <1421256142-11512-1-git-send-email-mst@redhat.com>
	<1421356698.3933.18.camel@nilsson.home.kraxel.org>
	<20150115213256.GA4813@redhat.com>
	<1421397146.21318.16.camel@nilsson.home.kraxel.org>
	<20150116084541.GA29204@redhat.com>
	<1421414833.21318.67.camel@nilsson.home.kraxel.org>
	<1421664883.3610.1.camel@nilsson.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1421664883.3610.1.camel@nilsson.home.kraxel.org>
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
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 19, 2015 at 11:54:43AM +0100, Gerd Hoffmann wrote:
>   Hi,
> 
> > I'm running 3.19-rc4 with this series applied in the guest, maybe I need
> > more?
> 
> Tried your vhost branch, rebased to 3.19-rc5 -- same result.  Hmm.
> 
> cheers,
>   Gerd
> 

Yes, it was all completely broken.
Looks like after making what looked like cosmetic changes, I run legacy
driver on new qemu and new driver on legacy qemu, but never new driver
on new qemu.

And sure enough, the "cosmetic" change inverted the logic testing probe
routine for success.

Sorry about that :(

I now posted fixed up patches: seem to work with net and block for me.

The easiest way to get the is probably from my git trees.

Thanks a lot for the reports!

-- 
MST
