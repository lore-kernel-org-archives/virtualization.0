From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [kvm-devel] [PATCH 00/10] PV-IO v3
Date: Wed, 22 Aug 2007 11:30:17 +0200
Message-ID: <200708221130.17364.borntraeger__31938.1234389313$1187775124$gmane$org@de.ibm.com>
References: <20070816231357.8044.55943.stgit@ghaskins-t60p.haskins.net>
	<200708221118.00990.borntraeger@de.ibm.com>
	<64F9B87B6B770947A9F8391472E032160D503D81@ehost011-8.exch011.intermedia.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <64F9B87B6B770947A9F8391472E032160D503D81@ehost011-8.exch011.intermedia.net>
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
To: Dor Laor <dor.laor@qumranet.com>
Cc: kvm-devel@lists.sourceforge.net, Gregory Haskins <ghaskins@novell.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am Mittwoch, 22. August 2007 schrieb Dor Laor:
> Actually while playing with virtio for kvm Avi saw that and recommended
> to do the following:
> struct desc_pages
> {
> 	/* Page of descriptors. */
> 	union {
> 		struct virtio_desc desc[NUM_DESCS];
> 		char pad1[PAGE_SIZE];
> 	};
[...]

Fine with me. Is anybody currently working on descriptor based transport for 
virtio for kvm?

Christian
