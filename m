From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [3.16 stable PATCH 1/2] virtio: rng: delay hwrng_register() till
	driver is ready
Date: Tue, 12 Aug 2014 13:24:33 +0530
Message-ID: <20140812075433.GN4184@grmbl.mre>
References: <76f5c012de1f6adeb1f8c105db5dc21a6e99fbc4.1407827215.git.amit.shah@redhat.com>
	<20140812074135.GB22911@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140812074135.GB22911@kroah.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Tue) 12 Aug 2014 [15:41:35], Greg KH wrote:
> On Tue, Aug 12, 2014 at 12:36:54PM +0530, Amit Shah wrote:
> > Instead of calling hwrng_register() in the probe routing, call it in the
> > scan routine.  This ensures that when hwrng_register() is successful,
> > and it requests a few random bytes to seed the kernel's pool at init,
> > we're ready to service that request.
> > 
> > This will also enable us to remove the workaround added previously to
> > check whether probe was completed, and only then ask for data from the
> > host.  The revert follows in the next commit.
> > 
> > There's a slight behaviour change here on unsuccessful hwrng_register().
> > Previously, when hwrng_register() failed, the probe() routine would
> > fail, and the vqs would be torn down, and driver would be marked not
> > initialized.  Now, the vqs will remain initialized, driver would be
> > marked initialized as well, but won't be available in the list of RNGs
> > available to hwrng core.  To fix the failures, the procedure remains the
> > same, i.e. unload and re-load the module, and hope things succeed the
> > next time around.
> > 
> > Signed-off-by: Amit Shah <amit.shah@redhat.com>
> > Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> > (cherry picked from commit 5c06273401f2eb7b290cadbae18ee00f8f65e893)
> > Signed-off-by: Amit Shah <amit.shah@redhat.com>
> > 
> > Conflicts:
> > 	drivers/char/hw_random/virtio-rng.c
> > 
> >   Context conflict due to not backporting two commits that changed
> >   struct layout.
> 
> What is this "Conflicts:" stuff for?  I don't need that...

To note the patch didn't cherry-pick as-is; anyway, sent a v2 without
that text.

Thanks,
		Amit
