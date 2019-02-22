From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] tpm: Add driver for TPM over virtio
Date: Fri, 22 Feb 2019 10:23:02 -0500
Message-ID: <20190222101728-mutt-send-email-mst@kernel.org>
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
	<20190222102610.GB5613@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190222102610.GB5613@linux.intel.com>
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

On Fri, Feb 22, 2019 at 12:26:10PM +0200, Jarkko Sakkinen wrote:
> On Thu, Feb 21, 2019 at 06:14:02PM -0800, David Tolnay wrote:
> > Add a config TCG_VIRTIO_VTPM which enables a driver providing the guest
> > kernel side of TPM over virtio.
> > 
> > Use case: TPM support is needed for performing trusted work from within
> > a virtual machine launched by Chrome OS.
> > 
> > Tested inside crosvm, the Chrome OS virtual machine monitor. Crosvm's
> > implementation of the virtio TPM device can be found in these two source
> > files:
> > 
> > - https://chromium.googlesource.com/chromiumos/platform/crosvm/+/18ce5713e6cb99c40aafec52b67c28ba12a44f31/devices/src/virtio/tpm.rs
> > - https://chromium.googlesource.com/chromiumos/platform/crosvm/+/18ce5713e6cb99c40aafec52b67c28ba12a44f31/tpm2/src/lib.rs
> 
> These files/links do not make sense for kernel testing. Please remove
> them from the next version.

To clarify generally for a virtio device we want
- guest support
- device support
- spec

If the device is implemented in qemu and guest in linux kernel,
then there are lots of people familiar with these
programming environments, so sometimes we merge
guest and host code even if spec isn't written up at all.

If you don't want to do that there's a small number of people who can
properly review code, e.g. I don't think lots of people on this list are
familiar with crosvm.  One way to address this would be to build a QEMU
implementation. Another would be to write up a spec.  You can do both
too :)



> > and is currently backed by the libtpm2 TPM simulator:
> > 
> > - https://chromium.googlesource.com/chromiumos/third_party/tpm2/
> > 
> > Reviewed-on: https://chromium-review.googlesource.com/1387655
> 
> A non-standard flag. Should be removed. Also
> 
> > Reviewed-by: Andrey Pronin <apronin@chromium.org>
> > Tested-by: David Tolnay <dtolnay@gmail.com>
> > Signed-off-by: David Tolnay <dtolnay@gmail.com>
> 
> Your SOB should first and you cannot peer test your own patches. Please
> remove tested-by.
> 
> The whole thing looks like an early draft. Why the patch does not have
> an RFC tag? You should use it for early drafts. Now it is like saying
> "please merge this".
> 
> I don't have much knowledge of virtio. The commit message should at
> least give rough overview what is meant by "kernel side" in this
> context.
> 
> Since one cannot use standard Linux environment to test this I'm not too
> optimistic about this getting merged any time soon. And since even the
> commit message is broken I don't think it makes sense to review the code
> in detail at this point.
> 
> /Jarkko
