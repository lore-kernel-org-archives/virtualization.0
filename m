From: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
Date: Fri, 01 Sep 2006 07:54:39 -0700
Message-ID: <1157122479.28577.64.camel@localhost.localdomain>
References: <20060901110948.GD15684@skybase>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20060901110948.GD15684@skybase>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, virtualization@lists.osdl.org, frankeh@watson.ibm.com, rhim@cc.gateh.edu, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Are all of the un/likely()s in here really needed?

-- Dave
