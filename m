From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH RFC V11 0/18] Paravirtualized ticket spinlocks
Date: Mon, 05 Aug 2013 15:50:49 -0700
Message-ID: <52002C49.1060201@zytor.com>
References: <20130722061631.24737.75508.sendpatchset@codeblue>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130722061631.24737.75508.sendpatchset@codeblue>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: jeremy@goop.org, gregkh@suse.de, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, drjones@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, stefano.stabellini@eu.citrix.com, xen-devel@lists.xensource.com, x86@kernel.org, mingo@redhat.com, habanero@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

So, having read through the entire thread I *think* this is what the
status of this patchset is:

1. Patches 1-17 are noncontroversial, Raghavendra is going to send an
   update split into two patchsets;
2. There are at least two versions of patch 15; I think the "PATCH
   RESEND RFC" is the right one.
3. Patch 18 is controversial but there are performance numbers; these
   should be integrated in the patch description.
4. People are in general OK with us putting this patchset into -tip for
   testing, once the updated (V12) patchset is posted.

If I'm misunderstanding something, it is because of excessive thread
length as mentioned by Ingo.

Either way, I'm going to hold off on putting it into -tip until tomorrow
unless Ingo beats me to it.

	-hpa
