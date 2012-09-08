From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] virtio-balloon spec: provide a version of the "silent
	deflate" feature that works
Date: Sat, 08 Sep 2012 12:32:06 +0200
Message-ID: <504B1EA6.8050304__47431.1829697855$1347100347$gmane$org@redhat.com>
References: <1346917610-14568-1-git-send-email-pbonzini@redhat.com>
	<20120906084736.GF17656@redhat.com> <50486BB2.7070108@redhat.com>
	<20120906094442.GA22816@redhat.com> <50487382.8030303@redhat.com>
	<20120906105301.GC32325@redhat.com>
	<5048935A.8090308@redhat.com> <87wr06hg0l.fsf@rustcorp.com.au>
	<20120907054202.GA3452@redhat.com> <87vcfqfia1.fsf@rustcorp.com.au>
	<20120907104306.GA17211@redhat.com>
	<87sjatf6iv.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87sjatf6iv.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: fes@google.com, aarcange@redhat.com, riel@redhat.com, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, yvugenfi@redhat.com, linux-kernel@vger.kernel.org, mikew@google.com, yinghan@google.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Il 08/09/2012 07:06, Rusty Russell ha scritto:
>> > Do we really know there are no hypervisors implementing it?
> As much as can be known.  Qemu doesn't, lkvm doesn't.
> 

However, there are cases in which it would be nice to have it.
Repurposing the bit to how it has been used so far (as a guest->host
communication bit, not host->guest) is a better choice.

Paolo
