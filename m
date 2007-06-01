From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: another RFC patch: bzImage with ELF payload
Date: Fri, 01 Jun 2007 14:38:24 -0700
Message-ID: <466091D0.1060803@zytor.com>
References: <46605E3D.3030009@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46605E3D.3030009@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Vivek Goyal <vgoyal@in.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> OK, here's another go-around.  This patch leaves the bzImage itself
> unmodified, but it changes the payload into an ELF file.  That is, the
> 32-bit decompression/relocation+compressed kernel is now a properly
> formed ELF file.
> 
> One thing that fell out of this is that code32_start end up being a
> pointer to the ELF header rather than an entrypoint.  Rather than
> reproducing Vivek's (?) hack of making the ELF header itself executable,
> I changed the 16-bit code to check for an ELF magic number at
> code32_start and use the e_entry to get the actual entrypoint.  This
> seems like approximately the right way of doing this, but I'm not sure
> how we want to formalize it.  It's certainly easier than trying to
> extract the payload's entry address and copying it to code32_start in
> the boot_params block, and we need a pointer to the ELF file itself anyway.
> 

No, that breaks any boot loader that uses the boot loader hook
mechanism.  That's definitely broken.

Either way, I still believe that this should be done at the other end of
the decompression chain.  Give out the information about *how the kernel
will be executed*, not about the intermediate, transient step.

	-hpa
