From: Paul Brook <paul@codesourcery.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] megaraid_sas HBA emulation
Date: Wed, 11 Nov 2009 01:49:05 +0000
Message-ID: <200911110149.05626.paul__3992.22190394557$1257904206$gmane$org@codesourcery.com>
References: <4AE71116.6080809@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4AE71116.6080809@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

> But I certainly do _not_ want to update the SCSI disk
> emulation, as this is really quite tied to the SCSI parallel
> interface used by the old lsi53c895a.c.

This is completely untrue. scsi-disk.c contains no transport-specific code. It 
is deliberately designed to be independent of both the transport (e.g. 
parallel SCSI or USB) and the mechanism by which the initiator transfers data 
to the host.

Paul
