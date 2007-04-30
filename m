From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 07/12] i386: Add missing !X86_PAE dependincy to the 2G/2G
 split.
Date: Mon, 30 Apr 2007 09:16:03 -0700
Message-ID: <46361643.509@zytor.com>
References: <m1d51l6f1y.fsf@ebiederm.dsl.xmission.com>	<m18xc96eyq.fsf@ebiederm.dsl.xmission.com>	<m14pmx6ewk.fsf_-_@ebiederm.dsl.xmission.com>	<m1zm4p509a.fsf_-_@ebiederm.dsl.xmission.com>	<m1vefd4zyj.fsf_-_@ebiederm.dsl.xmission.com>	<m1r6q14zow.fsf_-_@ebiederm.dsl.xmission.com>	<m1mz0p4zfc.fsf_-_@ebiederm.dsl.xmission.com>
	<m1irbd4zcm.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m1irbd4zcm.fsf_-_@ebiederm.dsl.xmission.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Eric W. Biederman wrote:
> When in PAE mode we require that the user kernel divide to be
> on a 1G boundary.  The 2G/2G split does not have that property
> so require !X86_PAE

?????

	-hpa
