From: "Dor Laor" <dor.laor@qumranet.com>
Subject: RE: [kvm-devel] [PATCH 00/10] PV-IO v3
Date: Wed, 22 Aug 2007 02:26:35 -0700
Message-ID: <64F9B87B6B770947A9F8391472E032160D503D81__45344.5992585786$1187774918$gmane$org@ehost011-8.exch011.intermedia.net>
References: <20070816231357.8044.55943.stgit@ghaskins-t60p.haskins.net>
	<1187714864.4363.358.camel@ghaskins-t60p.haskins.net>
	<1187753365.6174.26.camel@localhost.localdomain>
	<200708221118.00990.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <200708221118.00990.borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>, virtualization@lists.linux-foundation.org
Cc: kvm-devel@lists.sourceforge.net, Gregory Haskins <ghaskins@novell.com>
List-Id: virtualization@lists.linuxfoundation.org

>> +struct desc_pages
>> +{
>> +	/* Page of descriptors. */
>> +	struct lguest_desc desc[NUM_DESCS];
>> +
>> +	/* Next page: how we tell other side what buffers are available.
>*/
>> +	unsigned int avail_idx;
>> +	unsigned int available[NUM_DESCS];
>> +	char pad[PAGE_SIZE - (NUM_DESCS+1) * sizeof(unsigned int)];
>> +
>> +	/* Third page: how other side tells us what's used. */
>> +	unsigned int used_idx;
>> +	struct lguest_used used[NUM_DESCS];
>> +};
>
>Please consider to add this patch to make this data structure work on
64
>bit
>to make the second page, really page aligned. On 32 bit this should be
a
>no-op.
>
>Signed-Off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>
>---
> drivers/lguest/lguest_virtio.c |    3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>Index: lguest/drivers/lguest/lguest_virtio.c
>===================================================================
>--- lguest.orig/drivers/lguest/lguest_virtio.c
>+++ lguest/drivers/lguest/lguest_virtio.c
>@@ -33,11 +33,12 @@ struct desc_pages
> {
> 	/* Page of descriptors. */
> 	struct lguest_desc desc[NUM_DESCS];
>+	char pad0[PAGE_SIZE - NUM_DESCS * sizeof(struct lguest_desc)];
>
> 	/* Next page: how we tell other side what buffers are available.
>*/
> 	unsigned int avail_idx;
> 	unsigned int available[NUM_DESCS];
>-	char pad[PAGE_SIZE - (NUM_DESCS+1) * sizeof(unsigned int)];
>+	char pad1[PAGE_SIZE - (NUM_DESCS+1) * sizeof(unsigned int)];
>
> 	/* Third page: how other side tells us what's used. */
> 	unsigned int used_idx;


Actually while playing with virtio for kvm Avi saw that and recommended
to do the following:
struct desc_pages
{
	/* Page of descriptors. */
	union {
		struct virtio_desc desc[NUM_DESCS];
		char pad1[PAGE_SIZE];
	};

	/* Next page: how we tell other side what buffers are available.
*/
	union {
		struct {
			unsigned int avail_idx;
			unsigned int available[NUM_DESCS];
		};
		char pad2[PAGE_SIZE];
	};

	/* Third page: how other side tells us what's used. */
	union {
		struct {
			unsigned int used_idx;
			struct virtio_used used[NUM_DESCS];
		};
		char pad3[PAGE_SIZE];
	};
};

It saves useless pointer arithmetic.

--Dor
