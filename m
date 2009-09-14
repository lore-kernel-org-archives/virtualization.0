From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: pci: is reset incomplete?
Date: Mon, 14 Sep 2009 12:15:29 -0500
Message-ID: <4AAE7A31.9080600__1208.99567050419$1252948787$gmane$org@codemonkey.ws>
References: <20090914154822.GA3745@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090914154822.GA3745@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Michael S. Tsirkin wrote:
> Hi!
> pci bus reset does not seem to clear pci config registers, such as BAR
> registers, or memory space enable, of the attached devices: it only
> clears the interrupt state.
>
> This seems wrong, but easy to fix.
>   

I don't think most pci devices reset their config space in their reset 
callbacks.

I would think that making most of the config space (if not the entire) 
qdev properties would make sense.  You can then get reset for free and 
it's possible for users to tweak things like class codes universally.

Regards,

Anthony Liguori

> Comments?
>
>   
