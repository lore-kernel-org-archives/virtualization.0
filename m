From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch rfc wip] first cut of ELF bzImage
Date: Thu, 31 May 2007 13:22:18 -0700
Message-ID: <465F2E7A.3000802@goop.org>
References: <465E78D2.9080609@goop.org>
	<465E7CA2.6090201@zytor.com>	<465E7EC0.6080108@goop.org>
	<465F0B71.60303@zytor.com>
	<m1hcps3j86.fsf@ebiederm.dsl.xmission.com>
	<465F21AF.3080501@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <465F21AF.3080501@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Vivek Goyal <vgoyal@in.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

H. Peter Anvin wrote:
> Without any concept of what those "advanced features" are, we're just
> designing blind.  The only "advanced feature" I can think of that would
> be applicable is relocation, and that one is already taken care of.
>   

Well, I'm not sure what "advanced" really encompasses, but it seems to
me it would also include:

    * relocation
    * booting in protected mode
    * booting with paging enabled, which allows
    * physically discontigious kernels
    * ...?

    J
