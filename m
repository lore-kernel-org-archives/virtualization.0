From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] [PATCH 0001/001] xen: multi page ring support
	for block devices
Date: Thu, 15 Mar 2012 09:31:17 +0000
Message-ID: <4F61C4F50200007800078963@nat28.tlf.novell.com>
References: <1330701099-18281-1-git-send-email-santoshprasadnayak@gmail.com>
	<7914B38A4445B34AA16EB9F1352942F1010A1FA12364@SJCPMAILBOX01.citrite.net>
	<CAPbh3rsExLtohBwVd_scYuO=GN1iZE5egQQ3x5M59YUno5Rtyw@mail.gmail.com>
	<4F5739760200007800076DA6@nat28.tlf.novell.com>
	<230A793A-C929-468E-97BE-1C68920749E1@spectralogic.com>
	<4F60C888020000780007861F@nat28.tlf.novell.com>
	<59150D7B-8349-4249-A93A-04883F4AD744@spectralogic.com>
	<4F61B04402000078000788B8@nat28.tlf.novell.com>
	<1331801494.26979.8.camel@zakaz.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1331801494.26979.8.camel@zakaz.uk.xensource.com>
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
To: Ian Campbell <Ian.Campbell@citrix.com>
Cc: "jeremy@goop.org" <jeremy@goop.org>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, "waldi@debian.org" <waldi@debian.org>, "joe.jin@oracle.com" <joe.jin@oracle.com>, "weiyi.huang@gmail.com" <weiyi.huang@gmail.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Justin Gibbs <justing@spectralogic.com>, Paul Durrant <Paul.Durrant@citrix.com>, David Vrabel <david.vrabel@citrix.com>, SantoshJodh <Santosh.Jodh@citrix.com>, "<konrad@darnok.org>" <konrad@darnok.org>, "dgdegra@tycho.nsa.gov" <dgdegra@tycho.nsa.gov>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>, "lersek@redhat.com" <lersek@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

>>> On 15.03.12 at 09:51, Ian Campbell <Ian.Campbell@citrix.com> wrote:
> On Thu, 2012-03-15 at 08:03 +0000, Jan Beulich wrote:
>> >>> On 14.03.12 at 18:01, Justin Gibbs <justing@spectralogic.com> wrote:
>> > While we're talking about fixing ring data structures, can RING_IDX
>> > be defined as a "uint32_t" instead of "unsigned int".  The structure
>> > padding in the ring macros assumes RING_IDX is exactly 4 bytes,
>> > so this should be made explicit.  ILP64 machines may still be a way
>> > out, but the use of non-fixed sized types in places where size really
>> > matters just isn't clean.
>> 
>> Yes, if we're going to rev the interface, then any such flaws should be
>> corrected.
> 
> There has been talk of doing something similar for netif too. IIRC the
> netchannel2 work included a new generic ring scheme with support for
> variable sized req/rsp elements and such.
> 
> If we are going to rev the rings then should we try and use a common
> ring mechanism? I think so. If so then we could do worse than to start
> from the netchannel2 ring stuff and/or concepts?
> 
> Looks like that is
> http://xenbits.xen.org/ext/netchannel2/linux-2.6.18/log/075f6677a290/include 
> /xen/interface/io/uring.h
> still a bit nc2 specific though.

Taking the concept (and the implementation as a starting point) would
seem like a good idea to me. Separate request and reply rings as well
as variable size entries would certainly benefit blkif too.

Jan
