From: Amit Shah <amit.shah@redhat.com>
Subject: virtio: console: Barrier needed before dropping early_put_chars?
Date: Tue, 23 Feb 2010 22:40:22 +0530
Message-ID: <20100223171022.GB32564@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: borntraeger@de.ibm.com
Cc: hch@lst.de, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hey Rusty, Christian,

Christoph Hellwig asked why we don't need a barrier before this code in
virtcons_probe():

> +     /* Start using the new console output. */
> +     early_put_chars = NULL;
>       return 0;

Since only s390 uses early_put_chars so far, you'd know why it's not
needed / why we're safe.

Thanks,
		Amit
