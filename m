From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [Xen-devel] [PATCH RFC 1/3] virtio infrastructure
Date: Mon, 04 Jun 2007 14:19:41 -0700
Message-ID: <466481ED.8050209__12226.4702491977$1180992134$gmane$org@goop.org>
References: <1180613947.11133.58.camel@localhost.localdomain>	<08CA2245AFCF444DB3AC415E47CC40AFBD2CCF@G3W0072.americas.hpqcorp.net>	<1180779167.9228.66.camel@localhost.localdomain>
	<08CA2245AFCF444DB3AC415E47CC40AFBD2FD4@G3W0072.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <08CA2245AFCF444DB3AC415E47CC40AFBD2FD4@G3W0072.americas.hpqcorp.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Santos, Jose Renato G" <joserenato.santos@hp.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, jmk@plan9.bell-labs.com, Herbert Xu <herbert@gondor.apana.org.au>, kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <cborntra@de.ibm.com>, Suzanne McIntosh <skranjac@us.ibm.com>, Anthony Liguori <anthony@codemonkey.ws>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Santos, Jose Renato G wrote:
>   It seems that we will still need specific devices drivers
>   for each different virtualization flavor. For example,
>   we will still need to have a specific Xen netfront 
>   device that talks to a backend device in dom0, using
>   page grants, and other Xen specific mechanisms.
>   It looks like  will still need to maintain all the virtual device 
>   drivers and in addition we will now have to maintain 
>   another virtualization layer. 
>   

The hope is that the Xen-specific elements of the driver will be
restricted to Xen-specific things like grant tables, and the bulk of the
driver and its logic can be common.  Whether that can be achieved and
still retain the full performance/features of the entirely Xen-specific
netfront driver remains to be seen.  I haven't had a chance to look at
doing any Xen-virtio glue yet, so I'm not really sure how it will work out.

    J
