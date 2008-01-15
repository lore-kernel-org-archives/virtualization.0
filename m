From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_rng: adopt driver to newest virtio code
Date: Tue, 15 Jan 2008 11:01:42 +1100
Message-ID: <200801151101.43174.rusty@rustcorp.com.au>
References: <200801141651.47870.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200801141651.47870.borntraeger@de.ibm.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 15 January 2008 02:51:47 Christian Borntraeger wrote:
> Rusty,
>
> This patch changes the virtio_rng to a callback without a return value.
>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Thanks, applied.

BTW, virtio-rng was pretty much untested, so no huge surprise it has bugs.

Rusty.
