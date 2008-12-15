From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/4] virtio: do not statically allocate root device
Date: Tue, 16 Dec 2008 08:57:47 +1030
Message-ID: <200812160857.48321.rusty__2420.54940104044$1229380208$gmane$org@rustcorp.com.au>
References: <20081212190730.GB2950@kroah.com>
	<1229345909-27229-1-git-send-email-markmc@redhat.com>
	<1229345909-27229-2-git-send-email-markmc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1229345909-27229-2-git-send-email-markmc@redhat.com>
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
To: Mark McLoughlin <markmc@redhat.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, Kay Sievers <kay.sievers@vrfy.org>, Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Monday 15 December 2008 23:28:27 Mark McLoughlin wrote:
> We shouldn't be statically allocating the root device object,
> so dynamically allocate it using root_device_register()
> instead.

This and 3/4 which would normally go through me:

Acked-by: Rusty Russell <rusty@rustcorp.com.au>

Thanks Greg,
Rusty.
