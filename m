From: Zachary Amsden <zach@vmware.com>
Subject: Re: proposed interface change for setting the ldt
Date: Fri, 18 Aug 2006 20:41:11 -0700
Message-ID: <44E68857.6040806@vmware.com>
References: <44E599A3.6020907@goop.org> <44E621BA.6090001@vmware.com>
	<44E679ED.6010300@goop.org> <44E681B8.3020804@vmware.com>
	<20060819032249.GB10348@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20060819032249.GB10348@sequoia.sous-sol.org>
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
> * Zachary Amsden (zach@vmware.com) wrote:
>   =

>> The paravirt-op just got a lot harder to implement, so there is a cost =

>> to the simpler interface.
>>     =

>
> I'm missing why it's a lot harder.  Seems reasonably straight forward.
> puzzled...
>   =


Before it could be a direct call for us.  Now I am forced to write a =

wrapper function around it which does exactly the same work as the =

native code, them calls a ROM function.  It is straight forward, but =

obviously undesirable.

Zach
