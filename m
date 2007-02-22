From: Zachary Amsden <zach@vmware.com>
Subject: Re: rough sketch of revised patching infrastructure
Date: Thu, 22 Feb 2007 14:14:12 -0800
Message-ID: <45DE15B4.9060109@vmware.com>
References: <45DCFB6E.2010806@goop.org>	
	<1172115803.13378.63.camel@localhost.localdomain>	
	<45DD6EF7.9060808@goop.org>
	<1172141757.13378.76.camel@localhost.localdomain>
	<45DDDD50.80502@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45DDDD50.80502@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Rusty Russell wrote:
>   =

>> Actually, your paravirt_patch_insns has similar logic anyway, so this
>> code could collapse (it should fall back to paravirt_patch_default tho
>> IMHO).
>>   =

>>     =

>
> I wanted to get rid of the table because its now sparse, and possibly
> fairly large (since the special save flags & disable is at offset
> 0x80).  And a switch would be pretty clean anyway.
>
> How does this look?  Compiles, but untested.
>   =


That's looking pretty spiffy, if you ask me.

Zach
