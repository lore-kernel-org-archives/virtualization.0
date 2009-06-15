From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: Configuration vs. compat hints [was Re: [Qemu-devel] [PATCHv3
	03/13] qemu: add routines to manage PCI capabilities]
Date: Mon, 15 Jun 2009 13:24:04 -0500
Message-ID: <4A3691C4.4020509__45656.4688742675$1245090717$gmane$org@codemonkey.ws>
References: <1244821292.30522.56.camel@blaa>	
	<4A327E4A.7010300@codemonkey.ws>	<1244825303.26769.19.camel@blaa>	
	<20090614095016.GA7560@redhat.com>	<1245056916.6891.31.camel@blaa>	
	<4A3613EC.6030608@redhat.com>	<20090615103249.GB6351@redhat.com>	
	<4A363012.8050409@redhat.com>	<20090615114858.GG6351@redhat.com>	
	<4A3636FA.1040609@redhat.com>	<20090615124101.GH6351@redhat.com>	
	<4A364381.401@redhat.com>	<4A364401.6010500@codemonkey.ws>	
	<4A3647FB.9010808@redhat.com>	<4A364B53.9080007@codemonkey.ws>	
	<4A364FE0.40204@redhat.com> <4A3651EB.3070204@codemonkey.ws>	
	<4A36555A.4090303@redhat.com> <4A3659A0.3050108@codemonkey.ws>	
	<4A366348.1030202@redhat.com> <1245083229.3222.103.camel@blaa>
	<4A368F12.2090504@codemonkey.ws> <4A36912A.8090900@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A36912A.8090900@redhat.com>
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
Cc: Mark McLoughlin <markmc@redhat.com>, kvm@vger.kernel.org, Carsten Otte <cotte@de.ibm.com>, Glauber Costa <glommer@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paul Brook <paul@codesourcery.com>
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
> On 06/15/2009 09:12 PM, Anthony Liguori wrote:
>>
>> 2) Whenever the default machine type changes in a guest-visible way, 
>> introduce a new machine type
>
> s/whenever/qemu stable release/
>
>>  - Use explicit versions in name: pc-v1, pc-v2
>
> pc-qemu-0.10?
>
> This is similar to a hardware vendor's model number (though they tend 
> to change components without changing model numbers, though naughty 
> vendors)

Yup, that makes a whole lot of sense.

Regards,

Anthony Liguori
