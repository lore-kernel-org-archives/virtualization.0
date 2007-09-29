From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Lguest] [patch 34/43] lguest: Block driver using virtio.
Date: Sat, 29 Sep 2007 23:26:17 +1000
Message-ID: <1191072377.26950.34.camel@localhost.localdomain>
References: <20070926063618.956228976@rustcorp.com.au>
	<20070926063651.250184396@rustcorp.com.au>
	<1190979156.25555.13.camel@feisty>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1190979156.25555.13.camel@feisty>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chris Malley <mail@chrismalley.co.uk>
Cc: lguest@ozlabs.org, virtualization@lists.linux-foundation.org, Jens Axboe <jens.axboe@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-09-28 at 12:32 +0100, Chris Malley wrote:
> rusty@rustcorp.com.au wrote:
> > +	sprintf(vblk->disk->disk_name, "vd%c", virtblk_index++);
> 
> Update lguest documentation to reflect the new virtual block device name.
> 
> Signed-off-by: Chris Malley <mail@chrismalley.co.uk>

Thanks, applied!

Rusty.
