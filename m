From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH v3 01/11] kexec: introduce kexec firmware support
Date: Wed, 26 Dec 2012 20:46:27 -0800
Message-ID: <878v8k14rg.fsf@xmission.com>
References: <1356574740-6806-1-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-2-git-send-email-daniel.kiper@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1356574740-6806-2-git-send-email-daniel.kiper@oracle.com>
	(Daniel Kiper's message of "Thu, 27 Dec 2012 03:18:50 +0100")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: x86@kernel.org, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, hpa@zytor.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, jbeulich@suse.com, maxim.uvarov@oracle.com, tglx@linutronix.de, xen-devel@lists.xensource.com, vgoyal@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Daniel Kiper <daniel.kiper@oracle.com> writes:

> Some kexec/kdump implementations (e.g. Xen PVOPS) could not use default
> Linux infrastructure and require some support from firmware and/or hypervisor.
> To cope with that problem kexec firmware infrastructure was introduced.
> It allows a developer to use all kexec/kdump features of given firmware
> or hypervisor.

As this stands this patch is wrong.

You need to pass an additional flag from userspace through /sbin/kexec
that says load the kexec image in the firmware.  A global variable here
is not ok.

As I understand it you are loading a kexec on xen panic image.  Which
is semantically different from a kexec on linux panic image.  It is not
ok to do have a silly global variable kexec_use_firmware.

Furthermore it is not ok to have a conditional code outside of header
files.

Eric
