From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: todo
Date: Fri, 16 Mar 2007 21:03:06 -0700
Message-ID: <45FB687A.4090506@goop.org>
References: <20070317020011.GS10574@sequoia.sous-sol.org>	<45FB5707.3010809@goop.org>	<20070317033452.GU10574@sequoia.sous-sol.org>
	<45FB67E1.8040104@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <45FB67E1.8040104@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
>>   It also has one
>> negative side-effect, which is promoting external module code that links
>> with the kernel.  IOW, there's much less incentive to get code merged
>> if it's just a matter of linking.
>>     =

>
> It wouldn't be something we'd promote by making it easy to bind
> out-of-tree code to the interface.  And it would still be a
> kernel-version-specific ABI; no guarantees of stability.
BTW, my intention is definitely that all the pv-ops implementations are
linked into the kernel at build time; its just the binding references
get updated at boot time, and the unused code pages can be recycled. =

But they're all part of the same kernel image.

    J
