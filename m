From: Scott Wood <scottwood@freescale.com>
Subject: Re: RFC: vfio interface for platform devices (v2)
Date: Wed, 3 Jul 2013 18:06:22 -0500
Message-ID: <1372892782.8183.158__35965.8945621506$1372896495$gmane$org@snotra>
References: <9F6FE96B71CF29479FF1CDC8046E1503633DEF@039-SN1MPN1-004.039d.mgd.msft.net>
	<1372891989.2883.248.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="Flowed"; DelSp="Yes"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1372891989.2883.248.camel@ul30vt.home> (from
	alex.williamson@redhat.com on Wed Jul  3 17:53:09 2013)
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>, "kvm@vger.kernel.org list" <kvm@vger.kernel.org>, Antonios Motakis <a.motakis@virtualopensystems.com>, "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Yoder Stuart-B08248 <B08248@freescale.com>, Bhushan Bharat-R65777 <R65777@freescale.com>, Sethi Varun-B16395 <B16395@freescale.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
List-Id: virtualization@lists.linuxfoundation.org

On 07/03/2013 05:53:09 PM, Alex Williamson wrote:
> Seems like it should work.  My only API concern with this model of
> appending structs is that a user needs to know the size of each struct
> even if they don't otherwise care about it in order to step over it.

In that case, it might be better to make the struct grow linearly  
rather than with options, and just have a version number on the struct  
indicating how far the caller thinks struct has grown.  The kernel  
could respond back with a lower version to reflect that it only filled  
in the fields it knows about.  Flags could still be used to indicate  
which portions of the struct are relevant, but not the physical layout  
of the struct.

> In some cases, like the path, the size is variable and the user needs  
> to
> look into it.

For things like path, maybe the caller should just pass in a string  
buffer that is separate from the struct buffer?

-Scott
