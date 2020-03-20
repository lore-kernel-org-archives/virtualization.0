From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3,1/2] doc: zh_CN: index files in filesystems
 subdirectory
Date: Fri, 20 Mar 2020 17:19:52 -0600
Message-ID: <20200320171952.5a00ed84@lwn.net>
References: <20200315155258.91725-1-wenhu.wang@vivo.com>
        <20200316110143.97848-1-wenhu.wang@vivo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20200316110143.97848-1-wenhu.wang@vivo.com>
Sender: linux-doc-owner@vger.kernel.org
To: Wang Wenhu <wenhu.wang@vivo.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Harry Wei <harryxiyou@gmail.com>, Alex Shi <alex.shi@linux.alibaba.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jaskaran Singh <jaskaransingh7654321@gmail.com>, "Tobin C. Harding" <tobin@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, kernel@vivo.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 16 Mar 2020 04:01:31 -0700
Wang Wenhu <wenhu.wang@vivo.com> wrote:

> Add filesystems subdirectory into the table of Contents for zh_CN,
> all translations residing on it would be indexed conveniently.
> 
> Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
> ---
> Changelog since v1:
>  - v2: added SPDX header
>  - v3: rm raw latex field in translations/zh_CN/filesystems/index.rst
>         for none compatibility test with Sphinx 1.7.9 or later.
>        Actually only Sphinx v1.6.7 avalible for me currently.
>        Reviewed-by labels added

Both patches applied, thanks.

jon
