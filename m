From: Greg KH <gregkh@linuxfoundation.org>
Subject: is kexec on Xen domU possible?
Date: Thu, 18 Jul 2013 19:06:03 -0700
Message-ID: <20130719020603.GA22932@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: daniel.kiper@oracle.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Eric Biederman <ebiederm@xmission.com>
Cc: xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, Brandon Philips <brandon@ifup.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi all,

I was messing around with kexec and it seems to work just fine on KVM,
but for Xen domU images, it doesn't work at all.  Daniel, I saw some
patches from you back in September 2012 for adding this support for
Dom0, but they don't seem to have gone into the kernel (but other
patches went into kexec-tools at that time.)  You mention that domU
support is "easy" after your patches go in, is that because Dom0 needs
to support this, or is it something specific to only domU?

Also, what's the status of those patches for the kernel, I don't see
them reposted anywhere, did you drop them?

thanks,

greg k-h
