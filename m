From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] tpm: Add driver for TPM over virtio
Date: Fri, 22 Feb 2019 16:25:08 -0500
Message-ID: <20190222161636-mutt-send-email-mst@kernel.org>
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
	<20190222102610.GB5613@linux.intel.com>
	<20190222101728-mutt-send-email-mst@kernel.org>
	<20190222193156.GA6475@linux.intel.com>
	<20190222193305.GB6475@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190222193305.GB6475@linux.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: dgreid@chromium.org, virtualization@lists.linux-foundation.org, Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, apronin@chromium.org, David Tolnay <dtolnay@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 22, 2019 at 09:33:05PM +0200, Jarkko Sakkinen wrote:
> On Fri, Feb 22, 2019 at 09:31:56PM +0200, Jarkko Sakkinen wrote:
> > On Fri, Feb 22, 2019 at 10:23:02AM -0500, Michael S. Tsirkin wrote:
> > > On Fri, Feb 22, 2019 at 12:26:10PM +0200, Jarkko Sakkinen wrote:
> > > > On Thu, Feb 21, 2019 at 06:14:02PM -0800, David Tolnay wrote:
> > > > > Add a config TCG_VIRTIO_VTPM which enables a driver providing the guest
> > > > > kernel side of TPM over virtio.
> > > > > 
> > > > > Use case: TPM support is needed for performing trusted work from within
> > > > > a virtual machine launched by Chrome OS.
> > > > > 
> > > > > Tested inside crosvm, the Chrome OS virtual machine monitor. Crosvm's
> > > > > implementation of the virtio TPM device can be found in these two source
> > > > > files:
> > > > > 
> > > > > - https://chromium.googlesource.com/chromiumos/platform/crosvm/+/18ce5713e6cb99c40aafec52b67c28ba12a44f31/devices/src/virtio/tpm.rs
> > > > > - https://chromium.googlesource.com/chromiumos/platform/crosvm/+/18ce5713e6cb99c40aafec52b67c28ba12a44f31/tpm2/src/lib.rs
> > > > 
> > > > These files/links do not make sense for kernel testing. Please remove
> > > > them from the next version.
> > > 
> > > To clarify generally for a virtio device we want
> > > - guest support
> > > - device support
> > > - spec
> > > 
> > > If the device is implemented in qemu and guest in linux kernel,
> > > then there are lots of people familiar with these
> > > programming environments, so sometimes we merge
> > > guest and host code even if spec isn't written up at all.
> > > 
> > > If you don't want to do that there's a small number of people who can
> > > properly review code, e.g. I don't think lots of people on this list are
> > > familiar with crosvm.  One way to address this would be to build a QEMU
> > > implementation. Another would be to write up a spec.  You can do both
> > > too :)
> > 
> > I don't really understand your arguments.
> 
> ... and I did your response total three times and did not find any
> causality of any sort from anything.
> 
> /Jarkko

Thanks for spending the time reading my response.  What was included in
it was a general suggestion for a virtio based driver to be acceptable
in upstream Linux.

You pointed out that a pointer to a prototype implementation in Rust
isn't relevant. However, FYI just posting guest code and asking for it
to be merged alone won't work for a virtio driver either. I am merely
trying to speed things up instead of having the contributor repost with
a tweaked commit log just to immediately get another set of nacks.

-- 
MST
