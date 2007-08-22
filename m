From: "Dor Laor" <dor.laor@qumranet.com>
Subject: RE: [kvm-devel] [PATCH 00/10] PV-IO v3
Date: Wed, 22 Aug 2007 03:05:07 -0700
Message-ID: <64F9B87B6B770947A9F8391472E032160D503D94__15412.723812233$1187777341$gmane$org@ehost011-8.exch011.intermedia.net>
References: <20070816231357.8044.55943.stgit@ghaskins-t60p.haskins.net>
	<200708221118.00990.borntraeger@de.ibm.com>
	<64F9B87B6B770947A9F8391472E032160D503D81@ehost011-8.exch011.intermedia.net>
	<200708221130.17364.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <200708221130.17364.borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm-devel@lists.sourceforge.net, Gregory Haskins <ghaskins@novell.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

>> Actually while playing with virtio for kvm Avi saw that and
>recommended
>> to do the following:
>> struct desc_pages
>> {
>> 	/* Page of descriptors. */
>> 	union {
>> 		struct virtio_desc desc[NUM_DESCS];
>> 		char pad1[PAGE_SIZE];
>> 	};
>[...]
>
>Fine with me. Is anybody currently working on descriptor based
transport
>for
>virtio for kvm?
>

Yap, I'm working, I have network driver up and running, soon a block
device + patches.
Except me Gregory Haskins is working on a competing implementation, that
might be merged together
later on.
