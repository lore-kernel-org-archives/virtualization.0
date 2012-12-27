From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v3 00/11] xen: Initial kexec/kdump implementation
Date: Wed, 26 Dec 2012 23:53:49 -0800
Message-ID: <791b4922-078f-4adc-b3f3-0651f2266147@email.android.com>
References: <1356574740-6806-1-git-send-email-daniel.kiper@oracle.com>
	<50DBC856.6030208@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <50DBC856.6030208@zytor.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>, Daniel Kiper <daniel.kiper@oracle.com>
Cc: xen-devel@lists.xensource.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, jbeulich@suse.com, maxim.uvarov@oracle.com, tglx@linutronix.de, vgoyal@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

The syscall ABI still has the wrong semantics.

Aka totally unmaintainable and umergeable.

The concept of domU support is also strange.  What does domU support even mean, when the dom0 support is loading a kernel to pick up Xen when Xen falls over.

I expect a lot of decisions about what code can be shared and what code can't is going to be driven by the simple question what does the syscall mean.

Sharing machine_kexec.c and relocate_kernel.S does not make much sense to me when what you are doing is effectively passing your arguments through to the Xen version of kexec.

Either Xen has it's own version of those routines or I expect the Xen version of kexec is buggy.   I can't imagine what sharing that code would mean.  By the same token I can't any need to duplicate the code either.

Furthermore since this is just passing data from one version of the syscall to another I expect you can share the majority of the code across all architectures that implement Xen.  The only part I can see being arch specific is the Xen syscall stub.

With respect to the proposed semantics of silently giving the kexec system call different meaning when running under Xen,
/sbin/kexec has to act somewhat differently when loading code into the Xen hypervisor so there is no point not making that explicit in the ABI.

Eric
