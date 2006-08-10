From: Zachary Amsden <zach@vmware.com>
Subject: Re: EXPORT_SYMBOL_GPL(paravirt_ops);
Date: Thu, 10 Aug 2006 12:11:07 -0700
Message-ID: <44DB84CA.6040900@vmware.com>
References: <44DB73F5.5040009@goop.org>
	<20060810183250.GJ2654@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20060810183250.GJ2654@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Chris Wright wrote:
> * Jeremy Fitzhardinge (jeremy@goop.org) wrote:
>   =

>> This pretty much has to be EXPORT_SYMBOL(), otherwise we just required =

>> all modules to be GPL...
>>     =

>
> muwhahaha
>
> The plan is working...
>
> Yeah, I agree.  We had to do similar for LSM.
>
> thanks,
> -chris
>
>   =


EXPORT_SYMBOL_GPL is still possible - if you patch over every op in =

paravirt_ops.  Then only the paravirt modules need to be GPL, not all =

modules.

Zach
