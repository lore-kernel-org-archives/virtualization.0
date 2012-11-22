From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 01/11] kexec: introduce kexec_ops struct
Date: Thu, 22 Nov 2012 09:47:46 -0800
Message-ID: <50AE6542.3020302__4741.32455788112$1353606515$gmane$org@zytor.com>
References: <1353423893-23125-1-git-send-email-daniel.kiper@oracle.com>
	<1353423893-23125-2-git-send-email-daniel.kiper@oracle.com>
	<87lidwtego.fsf@xmission.com>
	<20121121105221.GA2925@host-192-168-1-59.local.net-space.pl>
	<87txshx28b.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87txshx28b.fsf@xmission.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: xen-devel@lists.xensource.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, Daniel Kiper <daniel.kiper@oracle.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, jbeulich@suse.com, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

The other thing that should be considered here is how utterly 
preposterous the notion of doing in-guest crash dumping is in a system 
that contains a hypervisor.  The reason for kdump is that on bare metal 
there are no other options, but in a hypervisor system the right thing 
should be for the hypervisor to do the dump (possibly spawning a clean 
I/O domain if the I/O domain is necessary to access the media.)

There is absolutely no reason to have a crashkernel sitting around in 
each guest, consuming memory, and possibly get corrupt.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
