From: "Eric Van Hensbergen" <ericvh@gmail.com>
Subject: Re: [Lguest] [patch 00/43] lguest: Patches for 2.6.24 (and
	patchbomb test)
Date: Tue, 9 Oct 2007 15:25:32 -0500
Message-ID: <a4e6962a0710091325s60d395dfo16b9dcc7a19620c7@mail.gmail.com>
References: <20070926063618.956228976@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070926063618.956228976@rustcorp.com.au>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "rusty@rustcorp.com.au" <rusty@rustcorp.com.au>
Cc: lguest@ozlabs.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 9/26/07, rusty@rustcorp.com.au <rusty@rustcorp.com.au> wrote:
> Hi all,
>
>         These are the patches I'm planning to submit for 2.6.24.  Comments
> gratefully accepted.  Along with the usual cleanups and improvements are Jes'
> de-i386-ification patches, and a new "virtio" mechanism designed to be shared
> with KVM (and hopefully other hypervisors).
>

I applied the patchbomb to a branch in the v9fs.git tree in prep to
write the virtio transport for 9p (it's under lguest-devel branch of
http://www.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git --
although for some reason guilt put my name as the Author in place of
Rusty everywhere...not sure why...anyways).

It built clean, but when I tried to make beer to read the updated docs
for virtio, it didn't seem to pick up the documentation for the
console, network, or block devices (just the core device support
code)....

Something stupid I'm doing wrong?

          -eric
