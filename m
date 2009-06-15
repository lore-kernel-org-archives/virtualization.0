From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: Configuration vs. compat hints [was Re: [Qemu-devel] [PATCHv3
	03/13] qemu: add routines to manage PCI capabilities]
Date: Mon, 15 Jun 2009 08:24:54 -0500
Message-ID: <4A364BA6.7050708__48491.7408939966$1245072349$gmane$org@codemonkey.ws>
References: <cover.1244192535.git.mst@redhat.com>	
	<20090610145540.GI19375@poweredge.glommer>	
	<20090610150129.GC28601@redhat.com>	
	<200906101624.30659.paul@codesourcery.com>	
	<20090610174301.GC7416@shareable.org>
	<20090610182227.GN28601@redhat.com>	
	<20090610192702.GH7416@shareable.org>
	<1244796209.16425.20.camel@blaa>	 <4A326C7E.3020309@codemonkey.ws>
	<1244822007.30522.68.camel@blaa>	 <4A327E87.6080005@codemonkey.ws>
	<1244825333.26769.20.camel@blaa>	 <4A34ADA9.80709@redhat.com>
	<1245056955.6891.33.camel@blaa> <4A36314A.8040206@redhat.com>
	<4A364316.5070402@codemonkey.ws> <4A3648BE.2050403@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A3648BE.2050403@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, Mark McLoughlin <markmc@redhat.com>, Glauber Costa <glommer@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jamie Lokier <jamie@shareable.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
>
> Certainly preferable to -baseline.
>
>> This is pretty easy to maintain with config files.
>
> Let's not tie the two together.

I mentioned it because it suggests a good transition.  We at least have 
to think through how things map to the post-config file world regardless 
of whether that's a few months from now or a decade :-)

Regards,

Anthony Liguori
